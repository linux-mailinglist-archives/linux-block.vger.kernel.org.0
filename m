Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB343BFA02
	for <lists+linux-block@lfdr.de>; Thu,  8 Jul 2021 14:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbhGHM13 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 8 Jul 2021 08:27:29 -0400
Received: from psionic.psi5.com ([62.113.204.72]:33278 "EHLO psionic.psi5.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229841AbhGHM13 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 8 Jul 2021 08:27:29 -0400
X-Greylist: delayed 361 seconds by postgrey-1.27 at vger.kernel.org; Thu, 08 Jul 2021 08:27:29 EDT
Received: by psionic.psi5.com (Postfix, from userid 1002)
        id BCA0D280299; Thu,  8 Jul 2021 14:18:41 +0200 (CEST)
Date:   Thu, 8 Jul 2021 14:18:41 +0200
From:   Simon Richter <Simon.Richter@hogyros.de>
To:     linux-block@vger.kernel.org
Subject: fast creation and deletion of loop devices
Message-ID: <20210708121841.GA228715@psi5.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

I have just used a crude loop to search for a partition on a block
device:

    for i in `seq 1 4096`
    do
        losetup -r -o ${i}k /dev/loop0 /dev/sda
        mount /dev/loop0 /mnt && break
        losetup -d /dev/loop0
    done

Creating the loop device fails sometimes, with

    losetup: /dev/sda: failed to set up loop device: Device or resource busy

and the kernel log contains a few instances of

    loop_set_status: loop0 () has still dirty pages (nrpages=5)

My machine is now in a state where I can call

    until losetup -d /dev/loop0; do :; done

and the loop just keeps running.

I'm slightly confused why a read-only loop device would have dirty pages
in the first place, and I suspect that there is a kernel bug here that
allows me to enter an inconsistent state through a race condition if I
just attach and detach loop devices fast enough.

   Simon
