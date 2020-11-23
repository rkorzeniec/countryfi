export function shadeColor (color, percent) {
  let decimalValue = Math.round(percent * 255 / 100)
  decimalValue = decimalValue <= 255 ? decimalValue : 255

  const alpha = percent < 7 ? '0' + toHex(decimalValue) : toHex(decimalValue)

  return color + alpha
}

function toHex (value) {
  return value.toString(16).toUpperCase()
}
