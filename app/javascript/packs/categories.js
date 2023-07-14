
  $(document).ready(function() {
    $('#category_parent_id').change(function() {
      var parentId = $(this).val();
      if (parentId !== '') {
        $.ajax({
          url: '/categories/subcategories',
          type: 'GET',
          data: { parent_id: parentId },
          dataType: 'json',
          success: function(data) {
            var options = '<option value="">Select a subcategory</option>';
            $.each(data, function(index, subcategory) {
              options += '<option value="' + subcategory.id + '">' + subcategory.name + '</option>';
            });
            $('#category_id').html(options);
          }
        });
      } else {
        $('#category_id').empty();
      }
    });
  });
