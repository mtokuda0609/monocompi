$(document).ready(function() {
  $('input[type=radio][name=ys]').change(function() {
    if ($(this).is(':checked')) {
      // アイテム追加フォームに用意した hidden_field に対して値を設定する
      $('#item_ys_code').val($(this).val());
    }
  });
})