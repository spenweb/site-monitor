const { PrismaClient } = require("@prisma/client")
const { ApolloServer } = require("apollo-server")
const Query = require("./resolvers/Query")
const User = require("./resolvers/User")
const Contact = require("./resolvers/Contact")
const typeDefs = require("./graphql-schema.js")

const prisma = new PrismaClient()

const resolvers = {
  Query,
  User,
  Contact,
}

const server = new ApolloServer({
  typeDefs,
  resolvers,
  context: (request) => ({ ...request, prisma }),
})

// The `listen` method launches a web server.
server.listen().then(({ url }) => {
  console.log(`🚀  Server ready at ${url}`)
})
