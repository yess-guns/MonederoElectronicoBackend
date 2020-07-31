from django.shortcuts import render
from django.http import JsonResponse
from django.contrib.auth.models import User
from django.contrib import auth
from django.contrib.auth import logout as do_logout

# Create your views here. 

def createUser(request):
    dataUser = User.objects.filter(username='Richard')
    if dataUser:
        return JsonResponse({'response':'Existe'})
    else:
        user = User.objects.create_user(username='Richard',password='Lunes123')
        user.is_staff = False
        user.save()
        return JsonResponse({'response':'Bien'})

def auntentificar(request):
    user = auth.authenticate(username='Richard', password='Lunes123')
    if user is not None:
        auth.login(request, user)
        return JsonResponse({'response':'ha iniciado sesión'})
    else:
        return JsonResponse({'response':'usuario incorrecto'})

def logout(request):
    do_logout(request)
    return JsonResponse({'response':'Sesión cerrada'})