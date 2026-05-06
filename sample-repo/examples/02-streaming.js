// Streaming chat — token-by-token output
import OpenAI from "openai";

const client = new OpenAI();

async function main() {
  const stream = await client.chat.completions.create({
    model: "gpt-4o-mini",
    stream: true,
    messages: [{ role: "user", content: "Write a haiku about coding agents." }],
  });

  for await (const chunk of stream) {
    const content = chunk.choices[0]?.delta?.content;
    if (content) process.stdout.write(content);
  }
  process.stdout.write("\n");
}

main().catch(console.error);
