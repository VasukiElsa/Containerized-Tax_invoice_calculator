#############################
# BASE IMAGE
#############################

FROM ubuntu AS build

RUN apt-get update && apt-get install -y openjdk-17-jdk

COPY . .

RUN javac -d /app TaxInvoiceCalculator/*.java

############################
#  MULTI STAGE BUILD
############################

FROM gcr.io/distroless/java17-debian12

# Copy the compiled binary from the build stage
COPY --from=build /app /app

# Set the entrypoint for the container to run the binary
ENTRYPOINT ["java", "-cp", "/app", "TaxInvoiceCalculator.DiscountWithGstForAProduct"]

