from django.urls import path

from accounts import views as accounts

login_patterns = ([
    path('createUser/',accounts.createUser),
    path('auntentificar/',accounts.auntentificar),
    path('logout/',accounts.logout),
    path('getUsers/',accounts.getUsers),
    path('updateUser/',accounts.updateUser),
],"accounts")

