function loadImage(obj)
  {
    var fileReader = new FileReader();
    fileReader.onload = function() {
    var element = document.getElementById('preview');
    element.src = fileReader.result;
    }
    fileReader.readAsDataURL(obj.files[0]);
  };
