// Function calling — let the model invoke tools
import OpenAI from "openai";

const client = new OpenAI();

const tools = [
  {
    type: "function",
    function: {
      name: "get_weather",
      description: "Get current weather for a city",
      parameters: {
        type: "object",
        properties: {
          city: { type: "string", description: "City name" },
          unit: { type: "string", enum: ["celsius", "fahrenheit"] },
        },
        required: ["city"],
      },
    },
  },
];

async function main() {
  const response = await client.chat.completions.create({
    model: "gpt-4o",
    tools,
    messages: [{ role: "user", content: "What's the weather in Bangkok?" }],
  });

  const call = response.choices[0].message.tool_calls?.[0];
  if (call) {
    console.log(`Tool: ${call.function.name}`);
    console.log(`Args: ${call.function.arguments}`);
  }
}

main().catch(console.error);
