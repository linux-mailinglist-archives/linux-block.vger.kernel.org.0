Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DCC112862C
	for <lists+linux-block@lfdr.de>; Sat, 21 Dec 2019 01:51:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfLUAvY (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 20 Dec 2019 19:51:24 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42946 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbfLUAvY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Dec 2019 19:51:24 -0500
Received: by mail-ot1-f67.google.com with SMTP id 66so14055859otd.9
        for <linux-block@vger.kernel.org>; Fri, 20 Dec 2019 16:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f33NX0mVyrexoBKmQnsG32ndr6o8M91RbejlTLuxhxw=;
        b=pKfg9UEBLsx6njksUWHLBV9YCmC5Ieahekn+9soc7jLMlGZN8QDuUe3MhuCdhXgXC6
         g0gDbbESs7X3oUrBExJ9JsdMsONU9A10XuSMv7r8Td92VT1lvZSJH3UfCQW1i7Y0MISg
         uS2PRHygg40RsyzjDa8SUbOj6VLjR2LDyqGO5Ul/NJDf/46uh1PoxGQX+YfMU/CyyhtG
         IsL2jFD1nFl5Z6Er0wIUYcOuiqmnJVB2yzStFIksAJDkZZdbo/uCNxgEImf+VVc9jwa2
         glafhYHVftVEBCWLnGSypqNiji5kRigGyeEpI9CJW0wN6LfgAQUPFbSEuCWO48b4Xx35
         0q0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f33NX0mVyrexoBKmQnsG32ndr6o8M91RbejlTLuxhxw=;
        b=tmX2QF4vV1kCLa7C4UBLx+nt5QJvPNQc2BfqawCTWrhexC9lpSGDkHs6WGk0yMg4ig
         p++786VF7PVjy0Tb5eXNDu33ETHEoddCXQ6lJtyrMRCLiJysQgmzScERx17dlNT+Loa7
         0NXVdHM9WyO78lO7elx4GriJgxmFiTqSBXyYmd+FNn0Ef6Mm8JQbaI6/RjgJKXZ3Yl83
         JpccYSnX1swdg0lAN3lkgU2+q/11SuupOj0HOkiHWofUzNdwjJ7J/vX8HXQzk1mv7soL
         syH8LD/DoGhFbu0nNmkThIsrk2H3mHiq/mj4tajwvOC2SQi8i9OnMVFb7+V4BHv0cqyj
         d2Qw==
X-Gm-Message-State: APjAAAVNj9lQzNJlYtY0UNiw35wQBu44DfeonGhvxz4jPRlbk0vEQ0wb
        /rcbB3bsHtYa+8ebWIwMIvOkR/AywS1baJgz4bXrRg==
X-Google-Smtp-Source: APXvYqxbY+fIz2rYDoZ2kDh5L9IxT6HAH53HFulCDl1AVxBdn9qKQM5q+s8gqlaKrOEYdyRgaFLwOdCutzqFOh8YHY0=
X-Received: by 2002:a9d:6f11:: with SMTP id n17mr4302678otq.126.1576889483302;
 Fri, 20 Dec 2019 16:51:23 -0800 (PST)
MIME-Version: 1.0
References: <20191216222537.491123-1-jhubbard@nvidia.com> <20191219132607.GA410823@unreal>
 <a4849322-8e17-119e-a664-80d9f95d850b@nvidia.com> <20191220092154.GA10068@quack2.suse.cz>
 <CAPcyv4gYnXE-y_aGehazzF-Kej5ibSfqvE2hTnjKJD68bm8ANg@mail.gmail.com> <437f2bff-13ba-0ae9-2f3c-bc8eb82d20f0@nvidia.com>
In-Reply-To: <437f2bff-13ba-0ae9-2f3c-bc8eb82d20f0@nvidia.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 20 Dec 2019 16:51:12 -0800
Message-ID: <CAPcyv4hMvTmb5X8gNtXnapJFR1qej1bKto2fvv9zUtebHMhvVw@mail.gmail.com>
Subject: Re: [PATCH v11 00/25] mm/gup: track dma-pinned pages: FOLL_PIN
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Jan Kara <jack@suse.cz>, Leon Romanovsky <leon@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Alex Williamson <alex.williamson@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Chinner <david@fromorbit.com>,
        David Airlie <airlied@linux.ie>,
        "David S . Miller" <davem@davemloft.net>,
        Ira Weiny <ira.weiny@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Jens Axboe <axboe@kernel.dk>,
        Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Paul Mackerras <paulus@samba.org>,
        Shuah Khan <shuah@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, bpf@vger.kernel.org,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, KVM list <kvm@vger.kernel.org>,
        linux-block@vger.kernel.org,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org,
        "Linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Netdev <netdev@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Maor Gottlieb <maorg@mellanox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Dec 20, 2019 at 4:41 PM John Hubbard <jhubbard@nvidia.com> wrote:
>
> On 12/20/19 4:33 PM, Dan Williams wrote:
> ...
> >> I believe there might be also a different solution for this: For
> >> transparent huge pages, we could find a space in 'struct page' of the
> >> second page in the huge page for proper pin counter and just account pins
> >> there so we'd have full width of 32-bits for it.
> >
> > That would require THP accounting for dax pages. It is something that
> > was probably going to be needed, but this would seem to force the
> > issue.
> >
>
> Thanks for mentioning that, it wasn't obvious to me yet.
>
> How easy is it for mere mortals outside of Intel, to set up a DAX (nvdimm?)
> test setup? I'd hate to go into this without having that coverage up
> and running. It's been sketchy enough as it is. :)

You too can have the power of the gods for the low low price of a
kernel command line parameter, or a qemu setup.

Details here:

https://nvdimm.wiki.kernel.org/how_to_choose_the_correct_memmap_kernel_parameter_for_pmem_on_your_system
https://nvdimm.wiki.kernel.org/pmem_in_qemu
