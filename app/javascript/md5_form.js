
import { Turbo } from "@hotwired/turbo-rails"
Turbo.start()


document.addEventListener('turbo:load', function() {
  const stringInput = document.getElementById('stringInput');
    const fileInput = document.getElementById('fileInput');
  
    stringInput.addEventListener('input', function() {
      if (stringInput.value.trim() !== "") {
        fileInput.disabled = true;
      } else {
        fileInput.disabled = false;
      }
    });
  
    fileInput.addEventListener('change', function() {
      if (fileInput.files.length > 0) {
        stringInput.disabled = true;
      } else {
        stringInput.disabled = false;
      }
    });
  });
  