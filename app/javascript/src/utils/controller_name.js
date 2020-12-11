export function getControllerName (identifier) {
  return identifier
    .split('--')
    .slice(-1)[0]
    .split(/[-_]/)
    .map(w => w.replace(/./, m => m.toUpperCase()))
    .join('')
    .replace(/^\w/, c => c.toLowerCase())
}
