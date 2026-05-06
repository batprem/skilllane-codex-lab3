// Vision — analyze an image
import OpenAI from "openai";

const client = new OpenAI();

async function main() {
  const imageUrl = "https://upload.wikimedia.org/wikipedia/commons/thumb/4/47/PNG_transparency_demonstration_1.png/280px-PNG_transparency_demonstration_1.png";

  const response = await client.chat.completions.create({
    model: "gpt-4o",
    messages: [
      {
        role: "user",
        content: [
          { type: "text", text: "Describe this image briefly." },
          { type: "image_url", image_url: { url: imageUrl } },
        ],
      },
    ],
  });

  console.log(response.choices[0].message.content);
}

main().catch(console.error);
