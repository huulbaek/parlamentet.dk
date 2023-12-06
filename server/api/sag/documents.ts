import prisma from '../../../prisma/client'

import { defineEventHandler } from 'h3'
import { parse } from 'node-html-parser';
import fetch from 'node-fetch'

function extractMainText(htmlContent: string): string {
  const root = parse(htmlContent);
  const bodyElement = root.querySelector('body');

  if (!bodyElement) return '';

  // Remove all <script> tags
  bodyElement.querySelectorAll('script').forEach((script) => script.remove());

  // Convert block-level elements to line breaks to preserve basic formatting
  bodyElement.querySelectorAll('p, br, div, h1, h2, h3, h4, h5, h6').forEach((element) => {
    element.insertAdjacentHTML('beforebegin', '\n');
  });

  // Extract text with preserved line breaks
  const formattedText = bodyElement.textContent.trim();

  return formattedText;
}

function convertPdfUrlToHtmlUrl(pdfUrl: string): string {
  // If the URL contains 'ripdf', replace '.pdf' with '.htm'
  if (pdfUrl.includes('ripdf')) {
    return pdfUrl.replace('.pdf', '.htm');
  }
  // If the URL does not contain 'ripdf', replace '.pdf' with '/index.htm'
  return pdfUrl.replace('.pdf', '/index.htm');
}

export default defineEventHandler(async (event) => {
  const query = getQuery(event)

  const sagId = parseInt(query.id, 10)


  // Fetch related SagDokument and SagstrinDokument, selecting only 2 of each
  const sagDocuments = await prisma.sagDokument.findMany({
    where: { sagid: sagId },
    include: { Dokument: { include: { Fil: true } } },
  })

  // const sagstrinDocuments = await prisma.sagstrinDokument.findMany({
  //   where: { Sagstrin: { sagid: sagId } },
  //   include: { Dokument: { include: { Fil: true } } },
  // })

  // Extract Fil records and convert PDF URLs to HTML
  const files = [...sagDocuments].flatMap((doc) =>
    doc.Dokument.Fil.map((file) => ({
      ...file,
      htmlUrl: convertPdfUrlToHtmlUrl(file.filurl)
    }))
  )

  const htmlContents = await Promise.all(files.map(async (file, index) => {
    try {
      const response = await fetch(file.htmlUrl);
      if (!response.ok) {
        throw new Error(`Failed to fetch HTML content from ${file.htmlUrl}`);
      }
      const html = await response.text();
      const mainText = extractMainText(html); // Use the function defined earlier
  
      // Append the mainText to the corresponding file object
      files[index].content = mainText;
      return mainText;
    } catch (error) {
      console.error('Error fetching HTML content:', error);
      // Append the error message to the corresponding file object
      files[index].content = null;
      files[index].error = error instanceof Error ? error.message : String(error);
      return null;
    }
  }));

  // Combine the files structure with their corresponding htmlContents
  const filesWithContent = files.map((file, index) => ({
    ...file,
    htmlContent: htmlContents[index]
  }));

  return filesWithContent;
  // Return the scraped HTML contents
  return htmlContents
})