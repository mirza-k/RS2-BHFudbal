#FROM mcr.microsoft.com/dotnet/core/runtime:3.1
#
#WORKDIR /app
#
## Copy csproj and restore as distinct layers
#COPY ./BHFudbal.Subscriber/*.csproj ./
#RUN dotnet restore "./BHFudbal.Subscriber.csproj"
#
## Copy everything else and build the app
#COPY ./BHFudbal.Subscriber/. ./
#RUN dotnet publish -c Release -o out
#
## Set the startup command
#CMD ["dotnet", "out/BHFudbal.Subscriber.dll"]
#-----

FROM mcr.microsoft.com/dotnet/core/sdk:3.1 AS build

WORKDIR /app

# Copy csproj and restore as distinct layers
COPY ./BHFudbal.Subscriber/*.csproj ./
RUN dotnet restore "./BHFudbal.Subscriber.csproj"

# Copy everything else and build the app
COPY ./BHFudbal.Subscriber/. ./
RUN dotnet publish -c Release -o out

# Build runtime image
FROM mcr.microsoft.com/dotnet/core/runtime:3.1

WORKDIR /app

COPY --from=build /app/out ./

CMD ["dotnet", "BHFudbal.Subscriber.dll"]