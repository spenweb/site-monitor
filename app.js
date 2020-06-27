const { PrismaClient } = require("@prisma/client")

const prisma = new PrismaClient()

async function main() {
  await prisma.contact.deleteMany({
    where: { firstName: "Spencer" },
  })
  await prisma.user.delete({
    where: { username: "spencer" },
  })
  const user = await prisma.user.create({
    data: {
      username: "spencer",
      password: "asdf",
    },
  })
  const contact = await prisma.contact.create({
    data: {
      firstName: "Spencer",
      lastName: "Brown",
      email: "spen@brown.com",
      creator: {
        connect: { userId: user.userId },
      },
    },
  })
  await prisma.user.update({
    where: { userId: user.userId },
    data: {
      contact: {
        connect: { contactId: contact.contactId },
      },
    },
  })
  const allUsers = await prisma.user.findMany()
  console.log(allUsers)
}

main()
  .catch((e) => {
    throw e
  })
  .finally(async () => {
    await prisma.disconnect()
  })
