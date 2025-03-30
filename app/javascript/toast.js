export function showToast(message, duration = 3000) {
  const toast = document.getElementById('simpleToast')
  const span = toast.querySelector('span')
  
  span.textContent = message
  toast.classList.add('show')
  
  setTimeout(() => {
    toast.classList.remove('show')
  }, duration)
}