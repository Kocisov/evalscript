const MainExpression = statements => {
  return `(() => {
    "use strict";
    ${statements}
  })();`
}

const LogExpression = (pos, value) => {
  console.log(pos)
  return `console.log(${value});`
}

const AddVarExpression = (name, value) => {
  return `var ${name} = ${value};`
}

export {
  MainExpression,
  LogExpression,
  AddVarExpression
}
