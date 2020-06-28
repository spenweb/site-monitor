const { gql } = require("apollo-server")

module.exports = gql`
  type Query {
    info: String!
    users: [User!]!
  }

  type User {
    contactId: Int
    createdTime: String!
    updatedTime: String
    userId: ID!
    username: String!
    contact: Contact
    createdContacts: [Contact!]!
  }

  type Contact {
    updatedTime: String
    contactId: ID!
    createdTime: String!
    creatorUserId: Int!
    email: String
    givenName: String!
    familyName: String
    phone: Int
    creator: User!
    user: User
  }
`
