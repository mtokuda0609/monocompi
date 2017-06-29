$(document).ready(function() {
  $('input[type=radio][name=rk]').change(function() {
    if ($(this).is(':checked')) {
      // アイテム追加フォームに用意した hidden_field に対して値を設定する
      $('#item_rk_code').val($(this).val());
    }
  });
})