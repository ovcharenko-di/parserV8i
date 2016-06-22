Перем Парсер;

Функция УдалитьКаталог(ПутьКаталога)
	Попытка
		УдалитьФайлы(ПутьКаталога);
	Исключение
		Сообщить(ОписаниеОшибки());
		Возврат Ложь;
	КонецПопытки;
	Возврат Истина;
КонецФункции // УдалитьКешБазы(База)

///  Очищает кеш всех баз из файла *.v8i
//
Функция ОчиститьВесьКеш() Экспорт
	СИ = Новый СистемнаяИнформация;
	Окружение = СИ.ПеременныеСреды();

	СписокБаз = Парсер.ПолучитьСписокБаз();

	Для каждого Стр Из СписокБаз Цикл
		База = Стр.Значение;

		Сообщить("Очистка кеша базы: " + База.Name);
		КаталогКеша = Окружение.Получить("USERPROFILE") + "\appdata\local\1c\1cv8\" + База.ID;
		Если УдалитьКаталог(КаталогКеша) Тогда
			Сообщить("	Очищен кеш базы: " + База.Name);
		Иначе
			Сообщить("	Возникли проблемы при очистке кеша базы: " + База.Name);
		КонецЕсли;

	КонецЦикла;

	Возврат Истина;
КонецФункции // ОчиститьВесьКеш()

Функция ПутьСоСлешем(Стр) Экспорт
	Если (Прав(СокрЛП(Стр),1) = """") Тогда
		Если (Прав(СокрЛП(Стр),2) <> "/""") Тогда
			Стр = Сред(СокрЛП(Стр),1,СтрДлина(СокрЛП(Стр))-1) + "/""";
		КонецЕсли;
	Иначе
		Стр = СокрЛП(Стр) + ?(Прав(СокрЛП(Стр),1)="/","","/");
	КонецЕсли;

	Возврат Стр;
КонецФункции // ПутьССлешем()

Функция ПутьСоОбратнымСлешем(Стр) Экспорт
	Если (Прав(СокрЛП(Стр),1) = """") Тогда
		Если (Прав(СокрЛП(Стр),2) <> "\""") Тогда
			Стр = Сред(СокрЛП(Стр),1,СтрДлина(СокрЛП(Стр))-1) + "\""";
		КонецЕсли;
	Иначе
		Стр = СокрЛП(Стр) + ?(Прав(СокрЛП(Стр),1)="\","","\");
	КонецЕсли;

	Возврат Стр;
КонецФункции // ПутьССлешем()


///  Очищает кеш базы
//
// Параметры:
//  Параметры      - Структура - Ключ: "Путь", Значение: Путь к БД;
//
// Возвращаемое значение:
//  Булево - Очистка прошла успешно/не успешно
//
Функция ОчиститьКешБазы(Параметры) Экспорт
	СИ = Новый СистемнаяИнформация;
	Окружение = СИ.ПеременныеСреды();

	СписокБаз = Парсер.ПолучитьСписокБаз();
	ПутьОчистки = "";
	Для каждого Стр Из СписокБаз Цикл
		База = Стр.Значение;

		Если База.Свойство("Connect") Тогда
			СтрБ = База.Connect.Structure;
			Если СтрБ.Свойство("File") Тогда
				//Сообщить(ПутьСоОбратнымСлешем(ВРЕГ(СтрБ.File)) +"|"+ ВРег(Параметры.Путь));
				Если ПутьСоОбратнымСлешем(ВРЕГ(СтрБ.File)) = ВРег(Параметры.Путь) Тогда
					ПутьОчистки = Окружение.Получить("USERPROFILE")+"\appdata\local\1c\1cv8\" + База.ID;
					Прервать;
				КонецЕсли;
			ИначеЕсли СтрБ.Свойство("ws") Тогда
				Если ПутьСоСлешем(ВРЕГ(СтрБ.ws)) = ВРег(Параметры.Путь) Тогда
					ПутьОчистки = Окружение.Получить("USERPROFILE")+"\appdata\local\1c\1cv8\" + База.ID;
					Прервать;
				КонецЕсли;
			ИначеЕсли СтрБ.Свойство("Srvr") Тогда
				Если ВРЕГ(СтрБ.Srvr) = ВРег(Параметры.Путь) Тогда
					ПутьОчистки = Окружение.Получить("USERPROFILE")+"\appdata\local\1c\1cv8\" + База.ID;
					Прервать;
				КонецЕсли;
			КонецЕсли;
		КонецЕсли;

	КонецЦикла;

	Если СокрЛП(ПутьОчистки) <> "" Тогда
		Если УдалитьКаталог(ПутьОчистки) Тогда
			Возврат Истина;
		Иначе
			Возврат Ложь;
		КонецЕсли;
	КонецЕсли;

	Возврат Ложь;
КонецФункции

Процедура УстановитьПарсер(Источник) Экспорт
	Парсер = Источник;
КонецПроцедуры

Функция ПолучитьПарсер() Экспорт
	Возврат Парсер;
КонецФункции
