export function shadeColor (color, percent) {
  const decimalValue = Math.round(percent * 255 / 100)
  const alpha = percent < 7 ? '0' + toHex(decimalValue) : toHex(decimalValue)

  return color + alpha
}

function toHex (value) {
  return value.toString(16).toUpperCase()
}
