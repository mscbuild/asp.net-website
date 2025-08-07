# Используем официальный образ .NET SDK для сборки
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Копируем CSPROJ и восстанавливаем зависимости
COPY *.csproj ./
RUN dotnet restore

# Копируем всё остальное и собираем приложение
COPY . ./
RUN dotnet publish -c Release -o out

# Используем ASP.NET Core Runtime для запуска
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /app/out .

# Открываем порт
EXPOSE 80

# Устанавливаем команду по умолчанию
ENTRYPOINT ["dotnet", "Indotalent.dll"]
