#include <adwaita.h>
#include <gtk/gtk.h>

static void
filedialog_on_open_cb (void *, void *, void *);
static void
filedialog_on_save_cb (void *, void *, void *);

static void
gtui_filedialog_save_finish (uint64_t dialog, uint64_t result, uint64_t data)
{
  GFile      *file = gtk_file_dialog_save_finish (dialog, result, NULL);
  const char *path = g_file_get_path (file);
  filedialog_on_save_cb (dialog, path, data);
}

static void
gtui_filedialog_save (uint64_t dialog, uint64_t data, uint64_t window)
{
  swift_retain (data);
  gtk_file_dialog_save (dialog, window, NULL, G_CALLBACK (gtui_filedialog_save_finish), (void *)data);
}

static void
gtui_filedialog_open_finish (uint64_t dialog, uint64_t result, uint64_t data)
{
  GFile      *file = gtk_file_dialog_open_finish (dialog, result, NULL);
  const char *path = g_file_get_path (file);
  filedialog_on_open_cb (dialog, path, data);
}

static void
gtui_filedialog_open (uint64_t dialog, uint64_t data, uint64_t window)
{
  swift_retain (data);
  gtk_file_dialog_open (dialog, window, NULL, G_CALLBACK (gtui_filedialog_open_finish), (void *)data);
}
