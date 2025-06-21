/*
*   Copyleft (C) 2025 linaix-os project.
*   Follow MIT License.
*/

/* include limine header */
#include <limine/limine.hpp>

/* include kernel header */
#include <init/main.hpp>

/* set limine request version */
__attribute__((section(".limine_requests"))) static volatile LIMINE_BASE_REVISION(3);


__attribute__((used, section(".limine_requests_start_marker"))) static const volatile LIMINE_REQUESTS_START_MARKER;
__attribute__((used, section(".limine_requests_end_marker"))) static const volatile LIMINE_REQUESTS_END_MARKER;

__attribute__((used, section(".limine_requests")))
static volatile struct limine_entry_point_request kernel_entry = {
    .id       = LIMINE_ENTRY_POINT_REQUEST,
    .revision = 3,
    .entry    = &_kernel_entry,
};

/* kernel entry */
extern "C" void _kernel_entry(void)
{

}