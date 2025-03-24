module.exports = {
  default: {
    formatOptions: {
      snippetInterface: 'synchronous'
    }
  },
  dev: {
    formatOptions: {
      snippetInterface: 'synchronous'
    },
    worldParameters: {
      logger: {
        level: 'info'
      },
      addAcceptGezagVersionHeader: true
    }
  }
}
