from django.conf import settings
from django.urls import path
from django.conf.urls.static import static

from .views import (
    BlogDetailView,
    BlogListView,
    EducationListView,
    FoodListView,
    MotivationListView,
    PoliticsListView,
)

urlpatterns = [
    path("education/", EducationListView.as_view(), name="education"),
    path("politics/", PoliticsListView.as_view(), name="politics"),
    path("food/", FoodListView.as_view(), name="food"),
    path("motivation/", MotivationListView.as_view(), name="motivation"),
    path("<str:slug>/", BlogDetailView.as_view(), name="detail"),
    path("", BlogListView.as_view(), name="home"),
]+ static(settings.STATIC_URL, document_root=settings.STATIC_ROOT) \
  + static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
