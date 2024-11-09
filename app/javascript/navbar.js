document.addEventListener('turbo:load', () => {
  const toggle = (btn, menu, hideMenu) => btn.onclick = e => {
    e.stopPropagation();
    menu.classList.toggle('hidden');
    hideMenu?.classList.add('hidden');
  };

  ['user', 'language'].forEach(type => {
    toggle(document.getElementById(`${type}-button`), document.getElementById(`${type}-menu`), document.getElementById(type === 'user' ? 'language-menu' : 'user-menu'));
  });

  document.onclick = () => {
    document.querySelectorAll('#user-menu, #language-menu').forEach(m => m.classList.add('hidden'));
    document.getElementById('default-sidebar').classList.add('-translate-x-full');
  };

  document.getElementById('sidebar-toggle').onclick = e => {
    e.stopPropagation();
    document.getElementById('default-sidebar').classList.toggle('-translate-x-full');
  };

  document.querySelectorAll('#language-menu a').forEach(link => link.onclick = e => {
    e.preventDefault();
    fetch('/update_locale', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json', 'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content },
      body: JSON.stringify({ locale: link.dataset.locale })
    }).then(res => res.ok && location.reload()).catch(console.error);
  });
});
