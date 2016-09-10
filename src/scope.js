const MainExpression = statements => {
  return `(() => {
    "use strict";
    ${statements}
  })();`
}

const LogExpression = (pos, value) => {
  return `console.log(${value});`
}

const AddVarExpression = (name, value) => {
  return `var ${name} = ${value};`
}

const FunctionExpression = (name, input, statements) => {
  if (input === 'noInput') {
    input = ''
  }

  if (statements === 'call') {
    return `${name}(${input});`
  }

  return `function ${name}(${input}) { ${statements} }`
}

const IfExpression = (ifs, statements) => {
  return `if (${ifs}) { ${statements} }`
}

const CreateFObject = (name, values) => {
  return `var ${name} = [ ${values} ];`
}

const ImportExpression = (that, from) => {
  return `import ${that} from ${from};`
}

const ExportExpression = that => {
  return `export default ${that};`
}

const Use = that => {
  return `@eval.use(${that})`
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
