const Query = {
  info: (parent, args, context, info) => "Site monitor graphql server",
  users: async (parent, args, context, info) => {
    const users = await context.prisma.user.findMany()
    return users
  },
}

module.exports = Query
