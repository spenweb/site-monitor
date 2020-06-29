import { nexusPrismaPlugin } from "nexus-prisma"
import { asNexusMethod } from "@nexus/schema"
import { intArg, makeSchema, objectType, stringArg } from "@nexus/schema"
import { GraphQLDate } from "graphql-iso-date"

export const GQLDate = asNexusMethod(GraphQLDate, "date")

const DateTime = String

const User = objectType({
  name: "User",
  definition(t) {
    t.model.userId()
    t.model.username()
    t.model.createdTime()
    t.model.updatedTime()
    t.model.contactId()
    t.model.contact()
    t.model.createdContacts()
  },
})

const Contact = objectType({
  name: "Contact",
  definition(t) {
    t.model.contactId()
    t.model.givenName()
    t.model.familyName()
    t.model.email()
    t.model.phone()
    t.model.createdTime()
    t.model.updatedTime()
    t.model.creatorUserId()
    t.model.creator()
    t.model.user()
  },
})

const Query = objectType({
  name: "Query",
  definition(t) {
    t.crud.user()
    t.list.field("users", {
      type: "User",
      resolve: (_, args, ctx) => {
        return ctx.prisma.user.findMany()
      },
    })
  },
})

const Mutation = objectType({
  name: "Mutation",
  definition(t) {
    t.field("register", {
      type: "User",
      args: {
        username: stringArg({ required: true }),
        password: stringArg({ required: true }),
      },
      resolve: (_, { username, password }, ctx) => {
        return ctx.prisma.user.create({
          data: {
            username,
            password,
          },
        })
      },
    })
  },
})

export const schema = makeSchema({
  types: [Query, Mutation, User, Contact, GQLDate, DateTime],
  plugins: [nexusPrismaPlugin()],
  outputs: {
    schema: __dirname + "/../schema.graphql",
    typegen: __dirname + "/generated/nexus.ts",
  },
  typegenAutoConfig: {
    contextType: "Context.Context",
    sources: [
      {
        source: "@prisma/client",
        alias: "prisma",
      },
      {
        source: require.resolve("./context"),
        alias: "Context",
      },
    ],
  },
})
