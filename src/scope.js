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
  return `function ${name}(${input}) { ${statements} }`
}

export {
  MainExpression,
  LogExpression,
  AddVarExpression,
  FunctionExpression
}
