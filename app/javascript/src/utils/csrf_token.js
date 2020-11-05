export function getCSRFToken() {
    return document.head.querySelector("meta[name='csrf-token']").content
  }
