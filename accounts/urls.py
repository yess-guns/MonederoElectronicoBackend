from django.urls import path

from accounts import views as accounts

login_patterns = ([
    path('user/',accounts.getUser),
    path('createUser/',accounts.createUser),
    path('auntentificar/',accounts.auntentificar),
    path('logout/',accounts.logout),
],"accounts")

