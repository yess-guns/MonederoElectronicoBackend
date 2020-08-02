from django.shortcuts import render
from django.http import JsonResponse
from django.contrib.auth.models import User
from django.contrib import auth
from django.contrib.auth import logout as do_logout
from django.views.decorators.csrf import csrf_exempt

# Create your views here. 
@csrf_exempt 
def createUser(request):
    nombre = request.POST['nombre']
    password = request.POST['pass']
    dataUser = User.objects.filter(username=nombre)
    if dataUser:
        return JsonResponse({'response':'Existe'})
    else:
        user = User.objects.create_user(username=nombre,password=password)
        user.is_staff = True
        user.save()
        return JsonResponse({'response':'Bien'})
@csrf_exempt 
def auntentificar(request):
    user = request.POST['user']
    password = request.POST['pass']
    validar = auth.authenticate(username=user, password=password)
    if validar is not None:
        #auth.login(request, user)
        dataUser = User.objects.filter(username=user)
        return JsonResponse({'response':'OK','dataUser': list(dataUser.values('first_name','last_name','is_staff'))})
    else:
        return JsonResponse({'response':'err'})

def logout(request):
    do_logout(request)
    return JsonResponse({'response':'Sesión cerrada'})