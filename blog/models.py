from django.db import models
from django.urls import reverse
from django.utils.html import mark_safe
from tinymce.models import HTMLField
# Create your models here.


class Blog(models.Model):
    Categories = [
        ("EN", "Education"),
        ("PT", "Politics"),
        ("FD", "Food"),
        ("MN", "Motivation"),
    ]
    title = models.CharField(max_length=250)
    slug = models.SlugField(max_length=250, unique=True)
    body = HTMLField()
    category = models.CharField(max_length=2, choices=Categories)
    author = models.ForeignKey("auth.User", on_delete=models.CASCADE)
    image = models.ImageField(upload_to="blog")
    date_created = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.title

    def get_absolute_url(self):
        return reverse("blog_detail", kwargs={"slug": self.slug})

    def img_preview(self):
        return mark_safe('<img src="{url}" width="200" />'.format(url=self.image.url))


