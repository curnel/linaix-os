/*
*   Copyleft (C) 2025 linaix-os project.
*   Follow MIT License.
*/

/* x86_64 elf format */
OUTPUT_FORMAT(elf64-x86-64)

/* kernel entry */
ENTRY(_kernel_entry)

/* kernel header */
PHDRS {
    /* PT_LOAD is loadable sections */
    limine_requests PT_LOAD FLAGS(4);
    dyn PT_LOAD FLAGS(4);
    text PT_LOAD FLAGS(5);
    rodata PT_LOAD FLAGS(4);
    data PT_LOAD FLAGS(6);
    ksymtab PT_LOAD FLAGS(4);
    dynamic PT_DYNAMIC FLAGS(6);
}

/* kernel sections */
SECTIONS {
    /* kernel entry address */
    /* limine request kernel entry high hemicore address */
    . = 0xffffffff80000000;

    /* limine request section */
    .limine_requests : ALIGN(8) {
        KEEP(*(.limine_requests_start))
        KEEP(*(.limine_requests))
        KEEP(*(.limine_requests_end))
    } : limine_requests
    
    /* 4096 align */
    . = ALIGN(4096);

    .gnu.hash : ALIGN(8) {
        *(.gnu.hash .gnu.hash.*)
    } : dyn

    .dynsym : ALIGN(8) {
        *(.dynsym .dynsym.*)
    } : dyn

    .dynstr : ALIGN(8) {
        *(.dynstr .dynstr.*)
    } : dyn

    .rela.dyn : ALIGN(8) {
        *(.rela.dyn .rela.dyn.*)
    } : dyn

    .rela.plt : ALIGN(8) {
        *(.rela.plt .rela.plt.*)
    } : dyn

    /* 4096 align */
    . = ALIGN(4096);


    /* kernel only read data section */
    .rodata : ALIGN(8) {
        *(.rodata .rodata.*)
    } :rodata

    /* 4096 align */
    . = ALIGN(4096);

    /* kernel codes section */
    .init : ALIGN(8) {
        *(.init .init.*)
    } : text

    .plt : ALIGN(8) {
        *(.plt .plt.*)
    } : text

    .plt.got : ALIGN(8) {
        *(.plt.got .plt.got.*)
    } : text

    .text : ALIGN(8) {
        *(.text .text.*)
    } : text

    .fini : ALIGN(8) {
        *(.fini .fini.*)
    } : text

    /* 4096 align */
    . = ALIGN(4096);

    /* kernel initialized data section*/
    .init_array : ALIGN(8) {
        *(.init_array .init_array.*)
    } : data

    .fini_array : ALIGN(8) {
        *(.fini_array .fini_array.*)
    } : data

    .data.rel.ro : ALIGN(8) {
        *(.data.rel.ro .data.rel.ro.*)
    } : data

    .dynamic : ALIGN(8) {
        *(.dynamic .dynamic.*)
    } : data : dynamic

    .got : ALIGN(8) {
        *(.got .got.*)
    } : data

    .data : ALIGN(8) {
        *(.data .data.*)
    } : data

    /* kernel uninitialized data section */
    .bss : ALIGN(8) {
        *(.bss .bss.*)
    } : data

    . = ALIGN(4096);

    .ksymtab : {
        __ksymtab_start = .;
        KEEP(*(.ksymtab))
        __ksymtab_end = .;
    } : ksymtab

    /* kernel discard section */
    /DISCARD/ : {
        *(.interp)
        *(.note .note.*)
        *(.gnu .gnu.*)
        *(.eh_frame*)
    }
}