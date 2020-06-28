const contact = (parent, args, context) =>
  context.prisma.user.findOne({ where: { userId: parent.userId } }).contact()

const createdContacts = (parent, args, context) =>
  context.prisma.user
    .findOne({ where: { userId: parent.userId } })
    .createdContacts()

module.exports = {
  contact,
  createdContacts,
}
