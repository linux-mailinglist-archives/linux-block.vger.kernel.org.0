Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1201C33E1
	for <lists+linux-block@lfdr.de>; Mon,  4 May 2020 09:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbgEDHwu (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 4 May 2020 03:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725941AbgEDHwt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 4 May 2020 03:52:49 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2286FC061A0E
        for <linux-block@vger.kernel.org>; Mon,  4 May 2020 00:52:48 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id x18so19724288wrq.2
        for <linux-block@vger.kernel.org>; Mon, 04 May 2020 00:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T/BCXLeMGlfl28bVnCThd/N+GspPrvkaYFXDfOTbFeg=;
        b=LfFfau2y70C+ZntFLZD/fU3R/OoRCrybfIDcL5eBSUcKKyfarjKxvX1nv/62UFBKM5
         JZfiqRy/gawz1IlmF0BcSbsp3aikrxPpeAU1CuHzvBOlZHEbh+OUfKlOdZ5naCWiiPmW
         1PR34P1ncpnLHs7s8s/fNrx1w9tmbehK0sR6YSovW/kbi8ksufIfb+jf5+yVn7PhFeWu
         CaaFSn1DATEtDLWwiR6qrXmg+K0PSN4/tmv2V+n1mWfsGHlFIZ8y9jKNCy04T5WxqLeW
         LNxD6xANZOTkB3b+xi6scvn1qvW2M3qvMS4LfFMlRy6F8ryN3vGlufstargTTyEC6AOt
         EYVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T/BCXLeMGlfl28bVnCThd/N+GspPrvkaYFXDfOTbFeg=;
        b=o/Bl1NjRzSKQsunV9Q2e+4fW0+i8tnlbrmUj4VkM1+QCpQVCdkJLTOEbOa5VRJ9dnQ
         8Pcoj0BpBZgAVVbGzpz6w+uabya2bfn6kyqg9WEFJ0k5XAfj+IdkoExgghvtnHmibNis
         6QAMXivjqUwm+u1djQN82lkhsNPI00hJHMhpI9YX63kkJFQlUwmJ2KrZD/D/PUVkWOM+
         zHVg4ymGhz+6uFUDX1Cb0tqAYBjmQTswp2pggZSgNddaqwnQ2W/pbfWQmGYpGt74+jH1
         3Xh4ROQRcOQI6DlK8am4co4hf74VIOQ2RBuYRrQLsi6jiy9cK68R2bq6m7VAUb5iDl3Q
         mE8g==
X-Gm-Message-State: AGi0Pub/VPqAKvxkB/gp/3kdDl8rkrFtQKeByFhZ4Nii4EPgcyu9bC9G
        hdrR+ps1LOvR9coJVR56bfcdnm4CeZOjBNE1llUf
X-Google-Smtp-Source: APiQypLUrQRmaA4T4meBIHrxh7MUXX6STzUzUMU2F+yIKJ+Tj47zmZd/1awyc/LGptL5VG9hJTPYZ+fqUnnIe5wYzgI=
X-Received: by 2002:a5d:5112:: with SMTP id s18mr4193634wrt.426.1588578766836;
 Mon, 04 May 2020 00:52:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200427141020.655-24-danil.kipnis@cloud.ionos.com>
 <202004292210.aw7c2Yi3%lkp@intel.com> <CAHg0HuzGwonGEbRyN03RZ7TiD4NdFWmr+YR7u9EG4VHyTT7V4w@mail.gmail.com>
 <7faf09fa-f38d-f54f-bd28-b4c26c936846@intel.com>
In-Reply-To: <7faf09fa-f38d-f54f-bd28-b4c26c936846@intel.com>
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
Date:   Mon, 4 May 2020 09:52:36 +0200
Message-ID: <CAHg0Huw90KRpPkeOX2_jo4sdroo_XXPW_1bFsgRE7te_Y3jn8g@mail.gmail.com>
Subject: Re: [PATCH v13 23/25] block/rnbd: include client and server modules
 into kernel compilation
To:     "Chen, Rong A" <rong.a.chen@intel.com>
Cc:     kbuild test robot <lkp@intel.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, kbuild-all@lists.01.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jinpu Wang <jinpu.wang@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, May 1, 2020 at 4:24 PM Chen, Rong A <rong.a.chen@intel.com> wrote:
>
>
>
> On 4/30/2020 4:48 PM, Danil Kipnis wrote:
> > On Wed, Apr 29, 2020 at 5:01 PM kbuild test robot <lkp@intel.com> wrote:
> >> Hi Danil,
> >>
> >> I love your patch! Yet something to improve:
> >>
> >> [auto build test ERROR on block/for-next]
> >> [also build test ERROR on driver-core/driver-core-testing rdma/for-next linus/master v5.7-rc3 next-20200428]
> >> [if your patch is applied to the wrong git tree, please drop us a note to help
> >> improve the system. BTW, we also suggest to use '--base' option to specify the
> >> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
> >>
> >> url:    https://github.com/0day-ci/linux/commits/Danil-Kipnis/RTRS-former-IBTRS-RDMA-Transport-Library-and-RNBD-former-IBNBD-RDMA-Network-Block-Device/20200428-080733
> >> base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
> >> config: i386-allyesconfig (attached as .config)
> >> compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
> >> reproduce:
> >>          # save the attached .config to linux build tree
> >>          make ARCH=i386
> >>
> >> If you fix the issue, kindly add following tag as appropriate
> >> Reported-by: kbuild test robot <lkp@intel.com>
> >>
> >> All errors (new ones prefixed by >>):
> >>
> >>     In file included from drivers/block/rnbd/rnbd-clt.c:19:0:
> >>>> drivers/block/rnbd/rnbd-clt.h:19:10: fatal error: rtrs.h: No such file or directory
> >>      #include "rtrs.h"
> >>               ^~~~~~~~
> >>     compilation terminated.
> >> --
> >>     In file included from drivers/block/rnbd/rnbd-srv.c:15:0:
> >>>> drivers/block/rnbd/rnbd-srv.h:16:10: fatal error: rtrs.h: No such file or directory
> >>      #include "rtrs.h"
> >>               ^~~~~~~~
> >>     compilation terminated.
> >>
> >> vim +19 drivers/block/rnbd/rnbd-clt.h
> >>
> >> 9e3ecd2f9c364e6 Jack Wang 2020-04-27  18
> >> 9e3ecd2f9c364e6 Jack Wang 2020-04-27 @19  #include "rtrs.h"
> >> 9e3ecd2f9c364e6 Jack Wang 2020-04-27  20  #include "rnbd-proto.h"
> >> 9e3ecd2f9c364e6 Jack Wang 2020-04-27  21  #include "rnbd-log.h"
> >> 9e3ecd2f9c364e6 Jack Wang 2020-04-27  22
> >>
> >> :::::: The code at line 19 was first introduced by commit
> >> :::::: 9e3ecd2f9c364e67eaa3ad19424b0d7ad6daacaa block/rnbd: client: private header with client structs and functions
> >>
> >> :::::: TO: Jack Wang <jinpu.wang@cloud.ionos.com>
> >> :::::: CC: 0day robot <lkp@intel.com>
> >>
> >> ---
> >> 0-DAY CI Kernel Test Service, Intel Corporation
> >> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> >
> > Dear kbuild test robot, dear All,
> >
> > the mentioned branch with the attached config compiles without errors
> > on my machine. Does anybody knows how to reproduce this include file
> > not found error or why does it come up in the kbuild test compilation?
>
> Hi Danil,
>
> The branch was generated by the bot, it may applied to a wrong base
> tree, could you take a look?
>
> url:    https://github.com/0day-ci/linux/commits/Danil-Kipnis/RTRS-former-IBTRS-RDMA-Transport-Library-and-RNBD-former-IBNBD-RDMA-Network-Block-Device/20200428-080733
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
>

Hi Rong Chen,

thanks for the reply. I directly checked out the branch
https://github.com/0day-ci/linux/commits/Danil-Kipnis/RTRS-former-IBTRS-RDMA-Transport-Library-and-RNBD-former-IBNBD-RDMA-Network-Block-Device/20200428-080733,
extracted the config attached to the bot's mail (it seems to be
"incomplete" make oldconfig still asks questions so I answered with
defaults) and did make ARCH=i386 as the mail suggests. Everything
compiled without errors... The only thing different is the compiler
version on my machine, but I doubt this is the reason...

Best,
Danil.


>
> Best Regards,
> Rong Chen
