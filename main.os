Функция ПолучитьСекциюФайлаПоИБ(кнф, "mc_bnu")
  СтруктураСекции = Новый Структура;

  Возврат СтруктураСекции;
КонецФункции

Функция ПрочитатьСекцию(ЧТ)
КонецФункции

//////////////////////////// ***** /////////////////////////////
кнф = "E:\_git_\ini_parse\ibases.v8i";
объ = ПолучитьСекциюФайлаПоИБ(кнф, "mc_bnu");

Для Каждого нн ИЗ объ Цикл
  Сообщить(""+нн.Ключ+" = "+нн.Значение);
КонецЦикла;

