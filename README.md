# BaseCaller

An app that fetches details from Truecaller and displays them in a simple UI. 
Displays information like image, name, number, provider, email(if registered) and location. Also displays a blue badge if the number is registered.

![1](https://user-images.githubusercontent.com/21179059/146418542-7ba397af-b05c-4677-b757-3ad4d4b32e0e.png)
![2](https://user-images.githubusercontent.com/21179059/146418762-b84f1f9e-6793-4f71-b887-bd9c9d0e60ce.png)

Use truecaller token to retrieve data

### Getting Truecaller auth token

(Tested with truecaller app version - 11.81.7)

Go to Truecaller app settings -> Privacy Center -> Download my data
Download the json file and open it.


Token is the value of key "id". It will look similar to -
```` 
a1i01--TQkyvDkO-VW8akLyvbyPBFxr11Fi_KOD1Sv1RGv7UPMJV-KU9C62xo4nd

```` 
