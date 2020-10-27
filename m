Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03F1229C7CA
	for <lists+linux-block@lfdr.de>; Tue, 27 Oct 2020 19:53:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1829151AbgJ0St4 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 27 Oct 2020 14:49:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:41432 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1829129AbgJ0St2 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Oct 2020 14:49:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BA698ACAA;
        Tue, 27 Oct 2020 18:49:27 +0000 (UTC)
Date:   Tue, 27 Oct 2020 19:49:26 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     linux-block@vger.kernel.org
Cc:     Martijn Coenen <maco@android.com>, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>, ltp@lists.linux.it,
        Cyril Hrubis <chrubis@suse.cz>
Subject: Ocassional dropping of uevent of loop device (possible race)
Message-ID: <20201027184926.GA24024@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi

commit 716ad0986cbd ("loop: Switch to set_capacity_revalidate_and_notify()")
from v5.8-rc1 caused occasional dropping of uevent of attached or detached loop
device (not sure which one). The only difference is that
set_capacity_revalidate_and_notify() has condition:
if (capacity != size && capacity != 0 && size != 0)
thus notification is not triggered here but in a different part of code.

It was found with LTP test uevent01 [1]:

# i=0; while true; do i=$((i+1)); echo "== $i =="; rmmod -f loop; ./uevent01 || break; done

It looks to be a race. Usually ~ 10 loops is enough.

Kind regards,
Petr
