from django.views.generic import ListView, DetailView

from .models import Blog

# Create your views here.


class BlogListView(ListView):
    model = Blog
    context_object_name = "blog_list"
    template_name = "home.html"
    paginate_by = 3  

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['recent_posts'] = self.object_list[:self.paginate_by]  # Get recent posts from object_list
        return context


class BlogDetailView(DetailView):
    template_name = "detail.html"

    def get_queryset(self):
        slug = self.kwargs.get("slug")
        blog = Blog.objects.filter(slug=slug)
        return blog


class EducationListView(ListView):
    template_name = "education.html"
    context_object_name = "education"
    def get_queryset(self):
        education = Blog.objects.filter(category__exact="EN")
        return education


class PoliticsListView(ListView):
    template_name = "politics.html"
    context_object_name = "politics"
    def get_queryset(self):
        politics = Blog.objects.filter(category="Politics")
        return politics


class FoodListView(ListView):
    template_name = "food.html"
    context_object_name = "food"
    def get_queryset(self):
        food = Blog.objects.filter(category="Food")
        return food


class MotivationListView(ListView):
    template_name = "motivation.html"
    context_object_name = "motivation"
    def get_queryset(self):
        motivation = Blog.objects.filter(category="Motivation")
        return motivation
