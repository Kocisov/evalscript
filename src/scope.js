let otps = {
  p: [],
  qp: {},
  variables: 'var',
  connect: 'require',
  export: 'module.exports'
}

const MainExpression = statements => {
  return `(() => {
    "use strict"
    ${statements}
  })()`
}

const LogExpression = (pos, value) => {
  return `console.log(${value})`
}

const AddVarExpression = (name, value) => {
  return `${opts.variables} ${name} = ${value}`
}

const FunctionExpression = (name, input, statements) => {
  if (input === 'noInput') {
    input = ''
  }

  if (statements === 'call') {
    return `${name}(${input})`
  }

  return `function ${name}(${input}) { ${statements} }`
}

const IfExpression = (ifs, statements) => {
  return `if (${ifs}) { ${statements} }`
}

const CreateFObject = (name, values) => {
  return `var ${name} = [ ${values} ]`
}

const ImportExpression = (that, from) => {
  /* TODO: if (opts.connect === '') {} ... */
  return `import ${that} from ${from}`
}

const ExportExpression = that => {
  return `export default ${that}`
}

const Use = that => {
  switch (that) {
    case 'expression':
      opts.variables = that
  }
}

export {
  MainExpression,
  LogExpression,
  AddVarExpression,
  FunctionExpression,
  IfExpression,
  CreateFObject,
  ImportExpression,
  ExportExpression,
  /* Ignore this */
  Use
}
