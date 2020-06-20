export function flashTimeout(flashId) {
  const flash = document.getElementById(flashId);

  setTimeout(function () { flash.remove(); }, 3000);
}
