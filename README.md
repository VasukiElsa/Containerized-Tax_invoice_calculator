Install Docker
-----
```$ sudo apt install docker.io -y```

Verify that docker is running by:
----

```$ docker run hello-world```

It shows permission denied error, because we install the docker with root user privilege. We want to add user to the docker group.

Add user to docker group
---

```$ sudo usermod -aG docker <username_of_your_machine>```

Then check the docker is started,
---

```$ sudo systemctl status docker```

Restart your machine to reflect the change.

About my TaxInvoiceCalculator
---
It calculates tax and gst based on category-based-product with discount and produces the final amount with caculated tax, discount and gst.\
Input format:\
It has five categories and each have a certain discount and gst that are\
Category 1 -> Product id = 1 , Discount = 25 and gst = 0\
Category 2 -> Product id = 2 , Discount = 17 and gst = 5\
Category 3 -> Product id = 3 , Discount = 12 and gst = 12\
Category 4 -> Product id = 4 , Discount = 9 and gst = 18\
Category 5 -> Product id = 5 , Discount = 30 and gst = 10


Define Dockerfile
---
-> Using Multi-stage-docker-build, we actually reduces the docker-image size and make it more secure.\
-> Using Distroless image, we ensure security. Here we using java-distroless-image, which contains only the java's runtime environment.

Stage one
---

1. Using Ubuntu as a base image and make it alias "build".
2. Install openjdk-17 required to compile java code.
3. Copying all the source code files from the current working directory into the current working docker container.
4. Compile all java source code into byte code, specifying the byte codes(.class files) is stored inside the \app directory.
5. Now \app directory containes the application's byte code.

Stage two
---

1. Get the java's distroless image from GoogleContainerTools/distroless - Github.
2. Then copy the compiled binary from the build stage.
3. Set the entry point for the binary to run the container.

Build the Dockerfile
---

```$ docker build -t vasukielsa/tax-invoice-calculator:java .```\
Here the . represents the current directory, which means dockerfile was found on the current directory.

Run the image
---

```$ docker run -it vasukielsa/tax-invoice-calculator```

Publish the image into the dockerhub
---
```$ docker login```\
```$ docker push vasukielsa/tax-invoice-calculator:java```

Check the image size
---
```$ docker images```\
You felt awesome, because it reduces our image size by using the multi-stage-builds and distroless image.


