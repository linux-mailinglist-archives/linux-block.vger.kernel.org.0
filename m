Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB671C830C
	for <lists+linux-block@lfdr.de>; Thu,  7 May 2020 09:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725893AbgEGHFk (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 7 May 2020 03:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725834AbgEGHFj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 7 May 2020 03:05:39 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D36AC061A41
        for <linux-block@vger.kernel.org>; Thu,  7 May 2020 00:05:39 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id y24so4588098edo.0
        for <linux-block@vger.kernel.org>; Thu, 07 May 2020 00:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+Jt+syXVKRHjTFMpydHnrsHY4rldPaD+CJQDRL9eN6I=;
        b=hQ0srGBNPx9CWNhbIY9XyjBl5Ay3lz/DUPkCQuSv1zWScjP/C5gDpv3/En1sXdzVkB
         mPW3SYMuxZIO3wI3ArHadHCeQxZ9vqU+KiNyGW0Qm4Irdb/4T413hoZT3qCZXeh9b2Tu
         uPhDgeoPjFjhSmguP2xiYppQthiUz5WE4kkGPht1U7jy6r9mZD/u7jV3DkRpO83bzTi9
         OW1XwKY/OaWZkpJ5FZbeMnLRDtyO8mEk/AIpa4X6adhbBVtV75LdIwV9vShBZlIbNLDz
         gDwGCGsWBqBaTA5JbJBQEcTK1urH0kDXkvZrmfly1+UMYfah+EURv2jJs+0ow+KotRuJ
         3Nqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+Jt+syXVKRHjTFMpydHnrsHY4rldPaD+CJQDRL9eN6I=;
        b=Nr/bf/R6zji4s0Q8QyoBcUTsrJvRFiXQHlbY0x6Olwgp3Rv54wAHIti4+m5OQuxAVN
         ZKz2g0XYL1l0nJcsxN5cge+M/UWaj4PPuemcRWutIbHkq6AvY7xjduU2gLCiTRmfkL4u
         cuWSjPTX+7c0Gx6D5vxoEXYL6ejzUvqCpeHSwTZHdwfpnX5seaiC4COEic1MJashrMCv
         +XH3nedYdhvoFwgatPYTlT50eqqFL4Gs0EykrGRQ70aaC0VAgZE58zdEvw5/SodZVXmT
         dBxzoJ0NSHTfVIjP05hHhXpvntAtFOv7EdCZk2UkE8fueaFjIj9uG5z+ch0xwvlPkSrt
         Rcgw==
X-Gm-Message-State: AGi0PubB00c8l/rPvkZzdf9eVdmF3BAxnYq0Iyb67RNeuXOLgGgtc32D
        wzpX78h+EF1uCa4ObHcSAlTKRQhQy2e+9ObpkD3OqQ==
X-Google-Smtp-Source: APiQypKbfjJSJPYlyVhp+ehOthmZ7/xMJPQJCiyIgVKs72QdtNmT8//Uw/UumHwXlmqOm9Q3DUVHj45ZvvPAUqOqupw=
X-Received: by 2002:aa7:d306:: with SMTP id p6mr10316811edq.35.1588835137732;
 Thu, 07 May 2020 00:05:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200504140115.15533-24-danil.kipnis@cloud.ionos.com> <202005060522.xI0z2eA6%lkp@intel.com>
In-Reply-To: <202005060522.xI0z2eA6%lkp@intel.com>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Thu, 7 May 2020 09:05:26 +0200
Message-ID: <CAMGffE=58PZSp3B14d_jCCKwPDr_YHoWxJs9gsmg-2Af60vnrw@mail.gmail.com>
Subject: Re: [PATCH v14 23/25] block/rnbd: include client and server modules
 into kernel compilation
To:     kbuild test robot <lkp@intel.com>
Cc:     Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        kbuild-all@lists.01.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi, Kbuild test robot,

On Tue, May 5, 2020 at 11:34 PM kbuild test robot <lkp@intel.com> wrote:
>
> Hi Danil,
>
> I love your patch! Yet something to improve:
>
> [auto build test ERROR on block/for-next]
> [also build test ERROR on driver-core/driver-core-testing rdma/for-next linus/master v5.7-rc4 next-20200505]
> [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system. BTW, we also suggest to use '--base' option to specify the
> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
>
> url:    https://github.com/0day-ci/linux/commits/Danil-Kipnis/RTRS-former-IBTRS-RDMA-Transport-Library-and-RNBD-former-IBNBD-RDMA-Network-Block-Device/20200505-072234
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
> config: c6x-allyesconfig (attached as .config)
> compiler: c6x-elf-gcc (GCC) 9.3.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day GCC_VERSION=9.3.0 make.cross ARCH=c6x
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kbuild test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>    In file included from drivers/block/rnbd/rnbd-clt.c:19:
> >> drivers/block/rnbd/rnbd-clt.h:19:10: fatal error: rtrs.h: No such file or directory
>       19 | #include <rtrs.h>
>          |          ^~~~~~~~
>    compilation terminated.
> --
>    In file included from drivers/block/rnbd/rnbd-srv.c:15:
> >> drivers/block/rnbd/rnbd-srv.h:16:10: fatal error: rtrs.h: No such file or directory
>       16 | #include <rtrs.h>
>          |          ^~~~~~~~
>    compilation terminated.
>
> vim +19 drivers/block/rnbd/rnbd-clt.h
looks somehow the "ccflags-y := -Idrivers/infiniband/ulp/rtrs " was
ignored in your case

We'll try to repro on ourside, can you also check on your side why
ccflags is ignored?

Thanks!
Jinpu
