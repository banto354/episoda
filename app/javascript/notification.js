$('#notifications-modal').on('show.bs.modal', function() {
    $('#notifications-body').load('/notifications');
  });
