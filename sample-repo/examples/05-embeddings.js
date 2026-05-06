// Embeddings — semantic similarity
import OpenAI from "openai";

const client = new OpenAI();

function cosineSimilarity(a, b) {
  let dot = 0, normA = 0, normB = 0;
  for (let i = 0; i < a.length; i++) {
    dot += a[i] * b[i];
    normA += a[i] ** 2;
    normB += b[i] ** 2;
  }
  return dot / (Math.sqrt(normA) * Math.sqrt(normB));
}

async function embed(text) {
  const response = await client.embeddings.create({
    model: "text-embedding-3-small",
    input: text,
  });
  return response.data[0].embedding;
}

async function main() {
  const texts = [
    "The agent reads code and runs commands.",
    "AI tools that automate developer workflows.",
    "Pizza is best with extra cheese.",
  ];

  const vectors = await Promise.all(texts.map(embed));
  console.log(`Sim(0,1): ${cosineSimilarity(vectors[0], vectors[1]).toFixed(3)}`);
  console.log(`Sim(0,2): ${cosineSimilarity(vectors[0], vectors[2]).toFixed(3)}`);
}

main().catch(console.error);
