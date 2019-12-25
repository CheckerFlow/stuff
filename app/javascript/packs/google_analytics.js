document.addEventListener('turbolinks:load', function(event) {
    if (typeof gtag === 'function') {
      gtag('config', 'G-86P9Y3DPJW', {
        'page_location': event.data.url
      })
    }
  })