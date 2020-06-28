const creator = (parent, args, context) => {
  const contact = context.prisma.contact.findOne({
    where: { contactId: parent.contactId },
  })
  return contact.creator()
}

const user = (parent, args, context) =>
  context.prisma.contact
    .findOne({ where: { contactId: parent.contactId } })
    .user()

module.exports = {
  creator,
  user,
}
