$(document).ready(function() {
  // When the user selection changes in the "Person who made the expense" dropdown
  $('#expense_user_id').change(function() {
    var selectedUserId = $(this).val();
    $('#expense_participant_ids option').prop('disabled', false);
    $('#expense_participant_ids option:selected').prop('selected', false);
    $('#expense_participant_ids option[value="' + selectedUserId + '"]').prop('disabled', true);
  });
});