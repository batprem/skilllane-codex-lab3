// Basic chat completion — single-turn
import OpenAI from "openai";

const client = new OpenAI();

async function main() {
  const response = await client.chat.completions.create({
    model: "gpt-4o-mini",
    messages: [
      { role: "system", content: "You are a concise assistant." },
      { role: "user", content: "Explain what an API is in one sentence." },
    ],
  });
  console.log(response.choices[0].message.content);
}

main().catch(console.error);
